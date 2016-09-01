class RenameAuthenticationTokenToApiKey < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :authentication_token, :api_key
  end
end
