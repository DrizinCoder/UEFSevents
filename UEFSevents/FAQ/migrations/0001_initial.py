# Generated by Django 5.1.7 on 2025-03-19 12:20

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='complaints',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('complaint_status', models.CharField(max_length=100)),
                ('complaint_reason', models.CharField(max_length=500)),
            ],
        ),
        migrations.CreateModel(
            name='questions',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('question_description', models.CharField(max_length=1000)),
                ('question_likes', models.IntegerField()),
                ('question_dislike', models.IntegerField()),
            ],
        ),
        migrations.CreateModel(
            name='answers',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('answer_description', models.CharField(max_length=1000)),
                ('answer_fk_question', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='FAQ.questions')),
            ],
        ),
    ]
