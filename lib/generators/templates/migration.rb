class CreateFlipFlopFeatureTable < ActiveRecord::Migration
  def self.up
    create_table :flip_flop_features do |t|
      t.string :name
      t.string :gate_type
      t.text :value
    end

    add_index :flip_flop_features, :name, unique: true
  end

  def self.down
    drop_table :flip_flop_features
  end
end