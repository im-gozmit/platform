class CreateDbs < ActiveRecord::Migration
  def change
    create_table "dbs" do |t|
      t.string   "name",       :null => false
      t.timestamps
    end
  end
end
