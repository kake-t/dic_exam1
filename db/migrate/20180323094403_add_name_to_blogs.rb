class AddNameToBlogs < ActiveRecord::Migration[5.1]
  def change
    add_column :blogs, :name, :string
  end
end
