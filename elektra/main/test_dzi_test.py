from django.test import TestCase
from .models import Task, School, Theme  # adjust this import based on your models' location
from .dzi_test import generate_test  # importing the function to test


class GenerateTestTestCase(TestCase):

    def setUp(self):
        # Setup code to create test data in the database
        self.school_1 = School.objects.create(name="School 1")
        self.school_2 = School.objects.create(name="School 2")

        self.theme = Theme.objects.create(title="Test Theme")

        # Create Tasks associated with the theme and schools
        self.task_1 = Task.objects.create(
            text="Question 1",
            author=self.school_1.id,
            item=1,
            level=1
        )
        self.task_2 = Task.objects.create(
            text="Question 2",
            author=self.school_1.id,
            item=1,
            level=2
        )
        # Create a task with a different author
        self.task_3 = Task.objects.create(
            text="Question 3",
            author=self.school_2.id,
            item=1,
            level=1
        )

        self.task_1.schools.add(self.school_2)  # add school_2 to task_1

    def test_generate_test_with_school_1(self):
        result = generate_test(theme_id=self.theme.id, user_school_id=self.school_1.id)
        # Check that the result contains questions authored by school_1
        self.assertIn(self.task_1, result)
        self.assertIn(self.task_2, result)
        # Ensure task_3 is not included
        self.assertNotIn(self.task_3, result)

    def test_generate_test_with_school_2(self):
        result = generate_test(theme_id=self.theme.id, user_school_id=self.school_2.id)
        # Check that the result contains questions authored by school_2
        self.assertIn(self.task_3, result)
        # Ensure task_1 and task_2 are included as task_1 has school_2 in its schools list
        self.assertIn(self.task_1, result)
        self.assertNotIn(self.task_2, result)


if __name__ == "__main__":
    import unittest

    unittest.main()