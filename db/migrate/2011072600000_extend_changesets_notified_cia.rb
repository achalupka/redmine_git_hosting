class ExtendChangesetsNotifiedCia < ActiveRecord::Migration
	def self.up
		add_column :changesets, :notified_cia, :integer, :default=>0
	end

	def self.down
		ActiveRecord::Base.connection.column_exists?(:changesets,:notified_cia) do
			remove_column :changesets, :notified_cia
		end
	end
end
