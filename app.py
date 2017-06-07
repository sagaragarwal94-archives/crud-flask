from flask import Flask, render_template, url_for, request, redirect, json
from flask_sqlalchemy import SQLAlchemy
from flask_bootstrap import Bootstrap

app = Flask(__name__)
app.config.from_pyfile('config.py')
db = SQLAlchemy(app)
bootstrap = Bootstrap(app)


class Categories(db.Model):
    __tablename__ = "category"
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(120), unique=True)

    def __init__(self, name):
        self.name = name

    def __repr__(self):
        return '<Name %r>' % self.name

class Items(db.Model):
    __tablename__ = "item"
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(120), unique=True)
    desc = db.Column(db.String(500), unique=False)
    cat_name = db.Column(db.String(120), unique = False)

    def __init__(self, name, desc, cat_name):
        self.name = name
        self.cat_name = cat_name
        self.desc = desc

    def __repr__(self):
        return '<Name %r>' % self.name



@app.route('/')	
def index():
	categories = Categories.query.all()
	items = Items.query.order_by(Items.id.desc()).limit(10).all()[::-1]
	last_show = {}
	for item in items:
		last_show[item.name] = item.cat_name
	return render_template("base.html", categories = categories, last_show = last_show, latest = True)


@app.route('/catalog/edit', methods = ['GET', 'POST'])
def add_item():
	if request.method == 'POST':
		name = request.form['name']
		desc = request.form['desc']
		category_name = request.form['category']
		item_add= Items(name, desc, category_name)
		db.session.add(item_add)
		db.session.commit()
		return redirect(url_for('index'))
	categories = Categories.query.all()
	return render_template("edit.html", name = "", value = "", categories = categories)

@app.route('/catalog/<category>/items')
def catalog(category):
	item_name = Items.query.filter_by(cat_name = category).all()
	categories = Categories.query.all()
	return render_template("base.html", categories = categories, category= category, item_name = item_name, latest = False)


@app.route('/catalog/<category>/<name>')
def describe(category, name):
	item_name = Items.query.filter_by(cat_name = category).first()
	return render_template("describe.html", desc= item_name.desc, name = item_name.name)

@app.route('/catalog/<item_name>/delete', methods = ['POST','GET'])
def delete(item_name):
	if request.method == 'POST':
		item_name = Items.query.filter_by(name = item_name).first()
		db.session.delete(item_name)
		db.session.commit()
		return redirect(url_for('index'))
	return render_template("delete.html")

@app.route('/catalog/<item_name>/edit', methods = ['POST','GET'])
def edit(item_name):
	item_name = Items.query.filter_by(name = item_name).first()
	categories = Categories.query.all()
	if request.method == 'POST':
		item_name.name = request.form['name']
		item_name.desc = request.form['desc']
		item_name.category_name = request.form['category']
		db.session.commit()
		return redirect(url_for('index'))
	return render_template("edit.html", name = item_name.name, desc = item_name.desc,categories = categories)

@app.route('/catalog.json')
def catalog_json():
	test =[]
	categories  = Categories.query.all()
	for category in categories:
		test_item=[]
		counter = 0
		item_name = Items.query.filter_by(cat_name = category.name).all()
		for item in item_name:
			counter = counter + 1
			test_item.append({"cat_id":category.id, "description": item.desc, "id": counter, "title": item.name })
		test.append({"id": category.id, "name": category.name, "Item": test_item})
	result={}
	result["Category"] = test
	response = app.response_class(
        response=json.dumps(result, indent=4, sort_keys=True),
        status=200,
        mimetype='application/json'
    )
	return response

if __name__ == '__main__':
	app.run(host='127.0.0.1', port=8000, debug=True)
