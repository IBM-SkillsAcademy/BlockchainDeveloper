#!/bin/bash
echo " Populate Ledger with Default Orders"

# curl -X POST "http://localhost:6001/api/v1/vehicles/orders" -H  "accept: */*" -H  "enrollment-id: Manu-User" -H  "Content-Type: application/json" -d "{\"orderID\":\"Order1\",\"manufacturer\":\"Honda\",\"model\":\"Civic\",\"color\":\"Black\",\"owner\":\"Tom\"}"

# curl -X POST "http://localhost:6001/api/v1/vehicles/orders" -H  "accept: */*" -H  "enrollment-id: Manu-User" -H  "Content-Type: application/json" -d "{\"orderID\":\"Order2\",\"manufacturer\":\"Toyota\",\"model\":\"Prius\",\"color\":\"Blue\",\"owner\":\"Alan\"}"

# curl -X POST "http://localhost:6001/api/v1/vehicles/orders" -H  "accept: */*" -H  "enrollment-id: Manu-User" -H  "Content-Type: application/json" -d "{\"orderID\":\"Order3\",\"manufacturer\":\"Volkswagen\",\"model\":\"Passat\",\"color\":\"Red\",\"owner\":\"John\"}"

# curl -X POST "http://localhost:6001/api/v1/vehicles/orders" -H  "accept: */*" -H  "enrollment-id: Manu-User" -H  "Content-Type: application/json" -d "{\"orderID\":\"Order4\",\"manufacturer\":\"Toyota\",\"model\":\"Accord\",\"color\":\"Black\",\"owner\":\"Smith\"}"

# curl -X POST "http://localhost:6001/api/v1/vehicles/orders" -H  "accept: */*" -H  "enrollment-id: Manu-User" -H  "Content-Type: application/json" -d "{\"orderID\":\"Order5\",\"manufacturer\":\"Hyundai\",\"model\":\"Tucson\",\"color\":\"Blue\",\"owner\":\"cathi\"}"


# curl -X POST "http://localhost:6001/api/v1/vehicles/orders" -H  "accept: */*" -H  "enrollment-id: Manu-User" -H  "Content-Type: application/json" -d "{\"orderID\":\"Order6\",\"manufacturer\":\"Honda\",\"model\":\"Civic\",\"color\":\"Black\",\"owner\":\"Adams\"}"

# curl -X POST "http://localhost:6001/api/v1/vehicles/orders" -H  "accept: */*" -H  "enrollment-id: Manu-User" -H  "Content-Type: application/json" -d "{\"orderID\":\"Order7\",\"manufacturer\":\"Toyota\",\"model\":\"Prius\",\"color\":\"Blue\",\"owner\":\"Henery\"}"

# curl -X POST "http://localhost:6001/api/v1/vehicles/orders" -H  "accept: */*" -H  "enrollment-id: Manu-User" -H  "Content-Type: application/json" -d "{\"orderID\":\"Order8\",\"manufacturer\":\"Volkswagen\",\"model\":\"Passat\",\"color\":\"Red\",\"owner\":\"Julia\"}"

# curl -X POST "http://localhost:6001/api/v1/vehicles/orders" -H  "accept: */*" -H  "enrollment-id: Manu-User" -H  "Content-Type: application/json" -d "{\"orderID\":\"Order9\",\"manufacturer\":\"Toyota\",\"model\":\"Accord\",\"color\":\"Black\",\"owner\":\"Chris\"}"

# curl -X POST "http://localhost:6001/api/v1/vehicles/orders" -H  "accept: */*" -H  "enrollment-id: Manu-User" -H  "Content-Type: application/json" -d "{\"orderID\":\"Order10\",\"manufacturer\":\"Hyundai\",\"model\":\"Tucson\",\"color\":\"Blue\",\"owner\":\"James\"}"



curl -X POST "http://localhost:6001/api/v1/vehicles/orders" -H  "accept: */*" -H  "enrollment-id: Manu-User" -H  "Content-Type: application/json" -d "{\"orderID\":\"Order11\",\"manufacturer\":\"Honda\",\"model\":\"Civic\",\"color\":\"Blue\",\"owner\":\"Mary\"}"

# curl -X POST "http://localhost:6001/api/v1/vehicles/orders" -H  "accept: */*" -H  "enrollment-id: Manu-User" -H  "Content-Type: application/json" -d "{\"orderID\":\"Order12\",\"manufacturer\":\"Toyota\",\"model\":\"Prius\",\"color\":\"Blue\",\"owner\":\"Tomas\"}"

# curl -X POST "http://localhost:6001/api/v1/vehicles/orders" -H  "accept: */*" -H  "enrollment-id: Manu-User" -H  "Content-Type: application/json" -d "{\"orderID\":\"Order13\",\"manufacturer\":\"Volkswagen\",\"model\":\"Passat\",\"color\":\"Black\",\"owner\":\"Sirnivas\"}"

# curl -X POST "http://localhost:6001/api/v1/vehicles/orders" -H  "accept: */*" -H  "enrollment-id: Manu-User" -H  "Content-Type: application/json" -d "{\"orderID\":\"Order14\",\"manufacturer\":\"Toyota\",\"model\":\"Accord\",\"color\":\"Orang\",\"owner\":\"Subermanian\"}"

# curl -X POST "http://localhost:6001/api/v1/vehicles/orders" -H  "accept: */*" -H  "enrollment-id: Manu-User" -H  "Content-Type: application/json" -d "{\"orderID\":\"Order15\",\"manufacturer\":\"Hyundai\",\"model\":\"Tucson\",\"color\":\"Red\",\"owner\":\"David\"}"


echo "Simulate updates over Order11 through Order15"

curl -X PUT "http://localhost:6001/api/v1/vehicles/orders" -H  "accept: */*" -H  "enrollment-id: Manu-User" -H  "Content-Type: application/json" -d "{\"orderID\":\"Order11\",\"status\":\"PENDING\"}"
curl -X PUT "http://localhost:6001/api/v1/vehicles/orders" -H  "accept: */*" -H  "enrollment-id: Manu-User" -H  "Content-Type: application/json" -d "{\"orderID\":\"Order11\",\"status\":\"INPROGRESS\"}"
curl -X PUT "http://localhost:6001/api/v1/vehicles/orders" -H  "accept: */*" -H  "enrollment-id: Manu-User" -H  "Content-Type: application/json" -d "{\"orderID\":\"Order11\",\"status\":\"DELIVERED\"}"

# curl -X PUT "http://localhost:6001/api/v1/vehicles/orders" -H  "accept: */*" -H  "enrollment-id: Manu-User" -H  "Content-Type: application/json" -d "{\"orderID\":\"Order12\",\"status\":\"PENDING\"}"
# curl -X PUT "http://localhost:6001/api/v1/vehicles/orders" -H  "accept: */*" -H  "enrollment-id: Manu-User" -H  "Content-Type: application/json" -d "{\"orderID\":\"Order12\",\"status\":\"INPROGRESS\"}"
# curl -X PUT "http://localhost:6001/api/v1/vehicles/orders" -H  "accept: */*" -H  "enrollment-id: Manu-User" -H  "Content-Type: application/json" -d "{\"orderID\":\"Order12\",\"status\":\"DELIVERED\"}"

# curl -X PUT "http://localhost:6001/api/v1/vehicles/orders" -H  "accept: */*" -H  "enrollment-id: Manu-User" -H  "Content-Type: application/json" -d "{\"orderID\":\"Order13\",\"status\":\"PENDING\"}"
# curl -X PUT "http://localhost:6001/api/v1/vehicles/orders" -H  "accept: */*" -H  "enrollment-id: Manu-User" -H  "Content-Type: application/json" -d "{\"orderID\":\"Order13\",\"status\":\"INPROGRESS\"}"
# curl -X PUT "http://localhost:6001/api/v1/vehicles/orders" -H  "accept: */*" -H  "enrollment-id: Manu-User" -H  "Content-Type: application/json" -d "{\"orderID\":\"Order13\",\"status\":\"DELIVERED\"}"

# curl -X PUT "http://localhost:6001/api/v1/vehicles/orders" -H  "accept: */*" -H  "enrollment-id: Manu-User" -H  "Content-Type: application/json" -d "{\"orderID\":\"Order14\",\"status\":\"PENDING\"}"
# curl -X PUT "http://localhost:6001/api/v1/vehicles/orders" -H  "accept: */*" -H  "enrollment-id: Manu-User" -H  "Content-Type: application/json" -d "{\"orderID\":\"Order14\",\"status\":\"INPROGRESS\"}"
# curl -X PUT "http://localhost:6001/api/v1/vehicles/orders" -H  "accept: */*" -H  "enrollment-id: Manu-User" -H  "Content-Type: application/json" -d "{\"orderID\":\"Order14\",\"status\":\"DELIVERED\"}"

# curl -X PUT "http://localhost:6001/api/v1/vehicles/orders" -H  "accept: */*" -H  "enrollment-id: Manu-User" -H  "Content-Type: application/json" -d "{\"orderID\":\"Order15\",\"status\":\"PENDING\"}"
# curl -X PUT "http://localhost:6001/api/v1/vehicles/orders" -H  "accept: */*" -H  "enrollment-id: Manu-User" -H  "Content-Type: application/json" -d "{\"orderID\":\"Order15\",\"status\":\"INPROGRESS\"}"
# curl -X PUT "http://localhost:6001/api/v1/vehicles/orders" -H  "accept: */*" -H  "enrollment-id: Manu-User" -H  "Content-Type: application/json" -d "{\"orderID\":\"Order15\",\"status\":\"DELIVERED\"}"

echo "Simulate vehicle creation over Order11 through Order15"

curl -X POST "http://localhost:6001/api/v1/vehicles" -H  "accept: */*" -H  "enrollment-id: Manu-User" -H  "Content-Type: application/json" -d "{\"orderID\":\"Order11\",\"manufacturer\":\"Honda\",\"model\":\"Civic\",\"color\":\"Blue\",\"owner\":\"Mary\"}"
# curl -X POST "http://localhost:6001/api/v1/vehicles" -H  "accept: */*" -H  "enrollment-id: Manu-User" -H  "Content-Type: application/json" -d "{\"orderID\":\"Order12\",\"manufacturer\":\"Toyota\",\"model\":\"Prius\",\"color\":\"Blue\",\"owner\":\"Tomas\"}"
# curl -X POST "http://localhost:6001/api/v1/vehicles" -H  "accept: */*" -H  "enrollment-id: Manu-User" -H  "Content-Type: application/json" -d "{\"orderID\":\"Order13\",\"manufacturer\":\"Volkswagen\",\"model\":\"Passat\",\"color\":\"Black\",\"owner\":\"Sirnivas\"}"
# curl -X POST "http://localhost:6001/api/v1/vehicles" -H  "accept: */*" -H  "enrollment-id: Manu-User" -H  "Content-Type: application/json" -d "{\"orderID\":\"Order14\",\"manufacturer\":\"Toyota\",\"model\":\"Accord\",\"color\":\"Orange\",\"owner\":\"Subermanian\"}"
# curl -X POST "http://localhost:6001/api/v1/vehicles" -H  "accept: */*" -H  "enrollment-id: Manu-User" -H  "Content-Type: application/json" -d "{\"orderID\":\"Order15\",\"manufacturer\":\"Hyundai\",\"model\":\"Tucson\",\"color\":\"Red\",\"owner\":\"David\"}"

echo "Simulate policy request over Order11 through Order15"

curl -X POST "http://localhost:6001/api/v1/vehicles/policies/request" -H "accept: */*" -H "enrollment-id: Manu-User" -H "Content-Type: application/json" -d "{\"id\":\"Policy11\",\"vehicleNumber\":\"Order11:Civic\",\"insurerId\":\"insurer1\",\"holderId\":\"holder1\",\"policyType\":\"THIRD_PARTY\",\"startDate\":\"12122021\",\"endDate\":\"31122021\"}"
# curl -X POST "http://localhost:6001/api/v1/vehicles/policies/request" -H "accept: */*" -H "enrollment-id: Manu-User" -H "Content-Type: application/json" -d "{\"id\":\"Policy12\",\"vehicleNumber\":\"Order12:Prius\",\"insurerId\":\"insurer1\",\"holderId\":\"holder1\",\"policyType\":\"THIRD_PARTY\",\"startDate\":\"12122021\",\"endDate\":\"31122021\"}"
# curl -X POST "http://localhost:6001/api/v1/vehicles/policies/request" -H "accept: */*" -H "enrollment-id: Manu-User" -H "Content-Type: application/json" -d "{\"id\":\"Policy13\",\"vehicleNumber\":\"Order13:Passat\",\"insurerId\":\"insurer1\",\"holderId\":\"holder1\",\"policyType\":\"THIRD_PARTY\",\"startDate\":\"12122021\",\"endDate\":\"31122021\"}"
# curl -X POST "http://localhost:6001/api/v1/vehicles/policies/request" -H "accept: */*" -H "enrollment-id: Manu-User" -H "Content-Type: application/json" -d "{\"id\":\"Policy14\",\"vehicleNumber\":\"Order14:Accord\",\"insurerId\":\"insurer1\",\"holderId\":\"holder1\",\"policyType\":\"THIRD_PARTY\",\"startDate\":\"12122021\",\"endDate\":\"31122021\"}"
# curl -X POST "http://localhost:6001/api/v1/vehicles/policies/request" -H "accept: */*" -H "enrollment-id: Manu-User" -H "Content-Type: application/json" -d "{\"id\":\"Policy15\",\"vehicleNumber\":\"Order15:Tucson\",\"insurerId\":\"insurer1\",\"holderId\":\"holder1\",\"policyType\":\"THIRD_PARTY\",\"startDate\":\"12122021\",\"endDate\":\"31122021\"}"









