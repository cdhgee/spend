jsondata = require "./jsondata"
sqlite3 = require "sqlite3"
  .verbose()
moment = require "moment"

db = new sqlite3.Database "data.db"

#stmt = db.prepare "INSERT INTO categories(name) VALUES (?)"
#stmt = db.prepare "INSERT INTO subcategories(name,category_id) SELECT ?, id FROM categories WHERE name=?"
#stmt = db.prepare "INSERT INTO paymentmethods(name) VALUES (?)"

stmt = db.prepare "INSERT INTO spend(person_id, date, vendor, location, paymentmethod_id, subcategory_id, amount, taxrate, discount_amount, discount_percentage, total, notes) SELECT p.id, ?, ?, ?, pm.id, sc.id, ?, ?, ?, ?, ?, ? FROM people p, paymentmethods pm, subcategories sc WHERE p.name = ? AND pm.name = ? AND sc.name = ?"

###
for x, cat of jsondata["Categories"]
  stmt.run cat["Category"]

for x, cat of jsondata["Subcategories"]
  stmt.run cat["Subcategory"], jsondata["Categories"][cat["Category"]]["Category"]

for x, cat of jsondata["Payment Methods"]
  stmt.run cat["Credit Card"]

###

for x, cat of jsondata["Spend"]
  person = if cat["Person"] is "" then "" else jsondata["People"][cat["Person"]]["Person"]
  sc = if cat["Subcategory"] is "" then "" else jsondata["Subcategories"][cat["Subcategory"]]["Subcategory"]
  pm = if cat["Payment Method"] is "" then "" else jsondata["Payment Methods"][cat["Payment Method"]]["Credit Card"]

  stmt.run moment(cat["Date"]).format("X"),
    cat["Store"],
    cat["Location"],
    cat["Amount"],
    cat["Tax Rate"],
    cat["Discount Amount"],
    cat["Discount Percent"],
    cat["Total"],
    cat["Notes"],
    person,
    pm,
    sc


stmt.finalize()

db.close()
