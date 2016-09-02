require 'rails_helper'

RSpec.describe Task, type: :model do
  it 'is a thing' do
    expect{Task.new}.to_not raise_error
  end

  it 'has a title and description' do
    task = Task.new
    task.make_new_task('Clean house', 'Wash floors')
    task2 = Task.find_by_title('Clean house')
    expect(task2.title).to eq 'Clean house'
    expect(task2.description).to eq 'Wash floors'
  end

  it 'can show me all the tasks' do
    task = Task.new
    task.make_new_task('Clean house', 'Wash floors')
    t = Task.find_by_title('Clean house')

    task2 = Task.new
    task.make_new_task('Dog Duty', 'Wash dog')
    t2 = Task.find_by_title('Dog Duty')

    task3 = Task.new
    task.make_new_task('Go to Bank', 'Withdraw money')
    t3 = Task.find_by_title('Go to Bank')

    expect(Task.all.pluck(:title)).to eq ['Clean house', 'Dog Duty', 'Go to Bank']
  end

  it 'can set a task to done' do
    task = Task.new
    task.make_new_task('Clean house', 'Wash floors')
    t = Task.find_by_title('Clean house')
    t.set_done(t)
    expect(t.task_finished).to eq true
  end

  it 'can list all the records that are done' do
    task = Task.new
    task.make_new_task('Clean house', 'Wash floors')
    t = Task.find_by_title('Clean house')
    t.set_done(t)

    task2 = Task.new
    task.make_new_task('Dog Duty', 'Wash dog')
    t2 = Task.find_by_title('Dog Duty')

    task3 = Task.new
    task.make_new_task('Go to Bank', 'Withdraw money')
    t3 = Task.find_by_title('Go to Bank')
    t3.set_done(t3)

    expect(Task.where("task_finished = 't'").pluck(:title)).to eq ['Clean house', 'Go to Bank']
  end

  it 'can list all the records that are not done' do
    task = Task.new
    task.make_new_task('Clean house', 'Wash floors')
    t = Task.find_by_title('Clean house')

    task2 = Task.new
    task.make_new_task('Dog Duty', 'Wash dog')
    t2 = Task.find_by_title('Dog Duty')

    task3 = Task.new
    task.make_new_task('Go to Bank', 'Withdraw money')
    t3 = Task.find_by_title('Go to Bank')
    t3.set_done(t3)

    expect(Task.where("task_finished = 'f'").pluck(:title)).to eq ['Clean house', 'Dog Duty']
  end

  it 'can update title and description of task' do
    task = Task.new
    task.make_new_task('Clean house', 'Wash floors')
    t = Task.find_by_title('Clean house')
    t.title = 'Groceries'
    t.description = 'Buy apples'
    t.save
    expect(t.title).to eq 'Groceries'
    expect(t.description).to eq 'Buy apples'
  end

  it 'can be destroyed' do
    task = Task.new
    task.make_new_task('Clean house', 'Wash floors')
    t = Task.find_by_title('Clean house')
    t.destroy
    expect(Task.find_by_title('Clean house')).to be nil
  end

  it 'can have a due date' do
    task = Task.new
    task.make_new_task('Clean house', 'Wash floors')
    t = Task.find_by_title('Clean house')
    t.due_date = '2016-09-01'
    expect(t.due_date).to eq '2016-09-01'
  end

  it 'can list all the tasks with a due date' do
    task = Task.new
    task.make_new_task('Clean house', 'Wash floors')
    t = Task.find_by_title('Clean house')
    t.due_date = '2016-09-01'
    t.save

    task2 = Task.new
    task.make_new_task('Dog Duty', 'Wash dog')
    t2 = Task.find_by_title('Dog Duty')
    t2.due_date = '2016-12-12'
    t2.save

    task3 = Task.new
    task.make_new_task('Go to Bank', 'Withdraw money')
    t3 = Task.find_by_title('Go to Bank')
    t3.save

    expect(Task.where('due_date is not NULL').pluck(:title)).to eq ['Clean house', 'Dog Duty']
  end

  it 'can list all the tasks with a due date today' do
    task = Task.new
    task.make_new_task('Clean house', 'Wash floors')
    t = Task.find_by_title('Clean house')
    t.due_date = '2016-09-01'
    t.save

    task2 = Task.new
    task.make_new_task('Dog Duty', 'Wash dog')
    t2 = Task.find_by_title('Dog Duty')
    t2.due_date = '2016-12-12'
    t2.save

    task3 = Task.new
    task.make_new_task('Go to Bank', 'Withdraw money')
    t3 = Task.find_by_title('Go to Bank')
    t3.save

    expect(Task.where(due_date:Date.today).pluck(:title)).to eq ['Clean house']
  end

  it 'can list all the tasks without a due date' do
    task = Task.new
    task.make_new_task('Clean house', 'Wash floors')
    t = Task.find_by_title('Clean house')
    t.due_date = '2016-09-01'
    t.save

    task2 = Task.new
    task.make_new_task('Dog Duty', 'Wash dog')
    t2 = Task.find_by_title('Dog Duty')
    t2.due_date = '2016-12-12'
    t2.save

    task3 = Task.new
    task.make_new_task('Go to Bank', 'Withdraw money')
    t3 = Task.find_by_title('Go to Bank')
    t3.save

    expect(Task.where('due_date is NULL').pluck(:title)).to eq ['Go to Bank']
  end
end
