INSERT INTO staging.stg_bangunan 
    (id, geom, shape_leng, shape_area, nama_bangu, nomor_bang,
    alamat, rt, rw, kelurahan, kecamatan, wilayah, jenis_bang,
    kepemilika, bangunan_t, penggunaan, fungsi, tingkatan, jenis_ba_1,
    sumber, nomor_imb, nomor_slf, link_foto, verifikasi, kode_aplik,
    created_us, created_da, las_edite, last_edi_1, nomor_krk,
    luas_tanah, luas_bangu, jumlah_bas, tp_sta_ban, grup_bang, deskripsi) 

SELECT
    id, geom, shape_leng, shape_area, nama_bangu, nomor_bang,
    alamat, rt, rw, kelurahan, kecamatan, wilayah, jenis_bang,
    kepemilika, bangunan_t, penggunaan, fungsi, tingkatan, jenis_ba_1,
    sumber, nomor_imb, nomor_slf, link_foto, verifikasi, kode_aplik,
    created_us, created_da, las_edite, last_edi_1, nomor_krk,
    luas_tanah, luas_bangu, jumlah_bas, tp_sta_ban, grup_bang, deskripsi

FROM public.pub_bangunan

ON CONFLICT(nomor_bang) 
DO UPDATE SET
    nama_bangu = EXCLUDED.nama_bangu,
    deskripsi = EXCLUDED.deskripsi,
    last_edi_1 = CASE WHEN 
                        staging.stg_bangunan.nama_bangu <> EXCLUDED.nama_bangu
                        OR staging.stg_bangunan.deskripsi <> EXCLUDED.deskripsi
                THEN 
                        CURRENT_TIMESTAMP
                ELSE
                        staging.stg_bangunan.last_edi_1
                END;