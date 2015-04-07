ActiveRecord::Schema.define version: 0 do
    self.verbose = false

    create_table :entities, force: true do |t|
        t.column :filename, :string
        t.column :file_size, :integer
        t.column :content_type, :string
    end

    create_table :custom_fields_entities, force: true do |t|
        t.column :picture_name, :string
        t.column :picture_size, :integer
        t.column :picture_type, :string
    end
end