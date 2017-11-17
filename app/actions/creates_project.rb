class CreatesProject
  attr_accessor :name, :task_string, :project, :users
  
  def initialize(name: "", task_string: "", users: [])
    @name = name
    @task_string = task_string
    @users = users
  end
  
  def build
    self.project = Project.new(name: name)
    project.add_users(users)
    project
  end
  
  def convert_string_to_tasks(user)
    task_string.split("\n").map.with_index(1) do |task_string, index|
      title, size = task_string.split(":")
      size = 1 if (size.blank? || size.to_i.zero?)
      Task.create(title: title, size: size,
        project_order: index, user_id: user.id)
    end
  end
  
  def create(user)
    build
    project.save
    project.tasks = convert_string_to_tasks(user)
  end
end