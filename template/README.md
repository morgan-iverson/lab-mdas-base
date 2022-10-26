(@ load("@ytt:data", "data") -@)
(@= data.values.workshop.title @)
(@= "="*len(data.values.workshop.title) @)

(@= data.values.workshop.description @)
