# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120430192719) do

  create_table "clients", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "example_groups", :force => true do |t|
    t.integer  "iteration_id"
    t.integer  "example_group_id"
    t.string   "description"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "example_groups", ["example_group_id"], :name => "index_example_groups_example_group_id"
  add_index "example_groups", ["iteration_id"], :name => "index_example_groups_iteration_id"

  create_table "examples", :force => true do |t|
    t.integer  "iteration_id"
    t.integer  "example_group_id"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.float    "run_time"
    t.string   "file_path"
    t.string   "line_number"
    t.string   "description"
    t.string   "state"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "examples", ["example_group_id"], :name => "index_examples_example_group_id"
  add_index "examples", ["iteration_id"], :name => "index_examples_iteration_id"

  create_table "iterations", :force => true do |t|
    t.integer  "project_id"
    t.string   "state",         :default => "unknown"
    t.integer  "example_count", :default => 0
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  add_index "iterations", ["project_id"], :name => "index_iterations_project_id"

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.integer  "client_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "projects", ["client_id"], :name => "index_projects_client_id"

end
