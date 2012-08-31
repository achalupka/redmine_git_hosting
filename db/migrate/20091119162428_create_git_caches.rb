class CreateGitCaches < ActiveRecord::Migration
	def self.up
		create_table :git_caches do |t|
			t.column :command, :text
			t.column :command_output, :binary
			t.column :proj_identifier, :string
			t.timestamps
#			t.index :command
		end
		#change_table :git_caches do |t|
		#	t.index :comand
		#end
	end
	def self.down
		drop_table :git_caches
	end
end
