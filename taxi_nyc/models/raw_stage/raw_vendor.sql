select ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) as id,
        vendorid as vendor_id,
        vendor_description,
        current_date() as load_date
from  {{ source('taxi_nyc_data', 'taxi_trips') }} AS trips join {{ source('taxi_nyc_data', 'vendor') }} as vendor
on trips.vendorid = vendor.vendor_id