INSERT INTO staging.stg_imb 
    (nomor_imb, tanggal_te, created_at, updated_at)

SELECT
    nomor_imb, 
    tanggal_te,
    CURRENT_TIMESTAMP AS created_at,
    CURRENT_TIMESTAMP AS updated_at


FROM public.pub_bangunan

ON CONFLICT(nomor_imb) 
DO UPDATE SET
    updated_at = CASE WHEN 
                        staging.stg_imb.nomor_imb <> EXCLUDED.nomor_imb

                THEN 
                        CURRENT_TIMESTAMP
                ELSE
                        stg.customer.updated_at
                END;