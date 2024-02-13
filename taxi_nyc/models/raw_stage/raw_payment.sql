select ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) as id,
        paymenttype as payment_id,
        payment.payment_type as payment_type,
        current_date() as load_date
from  {{ source('taxi_nyc_data', 'taxi_trips') }} AS trips join {{ source('taxi_nyc_data', 'payment') }} as payment
on trips.paymenttype = payment.payment_id