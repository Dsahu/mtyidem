class CreateGpDatas < ActiveRecord::Migration
  def self.up
    create_table :gp_datas do |t|
      t.integer :grandprix_id
      t.string :name
      t.integer :accum
      t.boolean :particip1
      t.boolean :particip2
      t.boolean :particip3
      t.boolean :particip4
      t.boolean :particip5
      t.boolean :particip6
      t.boolean :particip7
      t.boolean :particip8
      t.boolean :particip9
      t.boolean :particip10
      t.boolean :particip11
      t.boolean :particip12
      t.boolean :particip13
      t.boolean :particip14
      t.boolean :particip15
      t.boolean :particip16
      t.boolean :particip17
      t.boolean :particip18
      t.boolean :particip19
      t.boolean :particip20
      t.boolean :particip21
      t.boolean :particip22
      t.boolean :particip23
      t.boolean :particip24

      t.timestamps
    end
  end

  def self.down
    drop_table :gp_datas
  end
end
