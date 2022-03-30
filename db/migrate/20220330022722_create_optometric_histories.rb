class CreateOptometricHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :optometric_histories do |t|
      t.string :av_od_sc
      t.string :av_oi_sc
      t.string :av_od_cc
      t.string :av_oi_cc
      t.string :ph_od
      t.string :ph_oi
      t.string :k_od
      t.string :k_oi
      t.string :ret_od
      t.string :ret_oi
      t.string :rx_sph_od
      t.string :rx_sph_oi
      t.string :rx_cyl_od
      t.string :rx_cyl_oi
      t.string :rx_eje_od
      t.string :rx_eje_oi
      t.string :rx_dip_od
      t.string :rx_dip_oi
      t.string :mot_ocular
      t.string :cover_test
      t.string :kappa_od
      t.string :kappa_oi
      t.string :hirschberg
      t.string :rpupilares_fotom
      t.string :rpupilares_consensual
      t.string :rpupilares_acomodativo
      t.string :dnp_od
      t.string :dnp_oi
      t.string :av_od
      t.string :av_oi
      t.string :a_v_ao_od
      t.string :a_v_ao_oi
      t.string :cerca_add_od
      t.string :cerca_add_oi
      
      t.timestamps
    end
  end
end
