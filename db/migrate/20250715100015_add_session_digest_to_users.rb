class AddSessionDigestToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :session_digest, :string
  end
end
