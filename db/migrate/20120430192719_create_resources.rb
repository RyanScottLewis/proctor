class CreateResources < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name, :required => true
      t.timestamps
    end
    
    create_table :projects do |t|
      t.string :name, :required => true
      t.references :client
      t.timestamps
    end
    
    add_index 'projects', ['client_id'], :name => 'index_projects_client_id'
    
    create_table :iterations do |t|
      t.references :project
      t.string :state, :default => 'unknown'
      t.integer :example_count, :default => 0
      t.timestamps
    end
    
    add_index 'iterations', ['project_id'], :name => 'index_iterations_project_id'
    
    create_table :example_groups do |t|
      t.references :iteration
      t.references :example_group
      t.string :description
      t.timestamps
    end
    
    add_index 'example_groups', ['iteration_id'], :name => 'index_example_groups_iteration_id'
    add_index 'example_groups', ['example_group_id'], :name => 'index_example_groups_example_group_id'
    
    create_table :examples do |t|
      t.references :iteration
      t.references :example_group
      t.datetime :started_at
      t.datetime :finished_at
      t.float :run_time, :scale => 6
      t.string :file_path
      t.string :line_number
      t.string :description
      t.string :state
      
      t.timestamps
    end
    
    add_index 'examples', ['iteration_id'], :name => 'index_examples_iteration_id'
    add_index 'examples', ['example_group_id'], :name => 'index_examples_example_group_id'
  end
end