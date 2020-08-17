class EditDefaults < ActiveRecord::Migration[6.0]
  def change
    change_column_null :requests, :housing, false
    change_column_default :requests, :housing, false
    change_column_null :requests, :accepted, false
    change_column_default :requests, :accepted, false
    change_column_null :users, :sitter, false
    change_column_null :users, :owner, false
    change_column_null :users, :verified, false
    change_column_default :users, :sitter, false
    change_column_default :users, :owner, false
    change_column_default :users, :verified, false
  end
end
