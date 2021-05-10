59 23 * * * sleep 55; node /scripts/jx_cfdtx.js >> /scripts/logs/jx_cfdtx.log 2>&1
1 0-23/1 * * * node /scripts/jd_super_redrain.js >> /scripts/logs/jd_super_redrain.log 2>&1
30 20-23/1 * * * node /scripts/jd_half_redrain.js >> /scripts/logs/jd_half_redrain.log 2>&1