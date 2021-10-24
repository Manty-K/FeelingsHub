import uuid
from flask import Flask
from flask.json import jsonify
from flask_restful import Api, Resource

# Create App
app = Flask(__name__)
app.url_map.strict_slashes = False

api = Api(app)


pairs = []

# Functions

# function to update data
def update_data(sad_data, happy_data):
    with open("sad.txt", 'w') as sad:
        for data in sad_data:
            data += "\n"
            sad.write(data)
    
    with open("happy.txt", 'w') as happy:
        for data in happy_data:
            data += "\n"
            happy.write(data)

# function to get uuid
def get_uuid():
    return str(uuid.uuid4())

#function to open files
def get_file(which="all"):
    
    if which == "all":
        # opening file of sad people
        with open("sad.txt") as file:
            sad_data = file.readlines()
            sad_list = [sad_data[i][:-1] for i in range(len(sad_data))]

        # opening file of cheerful
        with open("happy.txt") as file:
            happy_data = file.readlines()
            happy_list = [happy_data[i][:-1] for i in range(len(happy_data))]
        
        return sad_list, happy_list
    elif which == "sad":
        # opening file of sad people
        with open("sad.txt") as file:
            sad_data = file.readlines()
            sad_list = [sad_data[i][:-1] for i in range(len(sad_data))]

        return sad_list
    elif which == "happy":
        # opening file of cheerful
        with open("happy.txt") as file:
            happy_data = file.readlines()
            happy_list = [happy_data[i][:-1] for i in range(len(happy_data))]
        
        return happy_list

# function to make pairs
def make_pairs() -> None:
    sad_list, happy_list = get_file()

    while sad_list and happy_list:
        convcode = get_uuid()
        sad = sad_list.pop(0)
        happy = happy_list.pop(0)

        pairs.append(
            {
                sad: convcode,
                happy: convcode
            }
        )
        print(pairs)    # for debugging purpose
        print("\n\n")   # for debugging purpose

    # Updating the data of sad & happy file
    update_data(sad_list, happy_list)

# function to update paired lists
def update_pairs(id):
    updated = False

    for i in range(len(pairs)):
        if id in pairs[i]:
            pairs.pop(i)
            updated = True

        if updated:
            break

class Home(Resource):
    def get(self):
        return """
        Get Sad list: https://url/sad
        Update Sad list: https://url/sad/<id>
        Get Happy list: https://url/happy
        Update Happy list: https://url/happy/<id>
        Get Pair: https://url/pair/<id>
        Remove Pair: https://url/remove/<id>
        """


class Depressed_Put(Resource):
    def put(self, id):
        with open("sad.txt", 'a') as sad:
            id += "\n"
            sad.write(id)
        return jsonify("Added")
    

class Depressed_Get(Resource):
    def get(self):
        sad_list = get_file(which="sad")
        return sad_list


class Happy_Put(Resource):
    def put(self, id):
        with open("happy.txt", 'a') as happy:
            id += "\n"
            happy.write(id)
        return jsonify("Added")


class Happy_Get(Resource):
    def get(self):
        happy_list = get_file(which="happy")
        return happy_list


class Get_Pair(Resource):
    def get(self, id):
        make_pairs()
        sad_list, happy_list = get_file()
        if id in sad_list or id in happy_list:
            return "Not Paired Yet", 202
        elif any([id in d for d in pairs]):
            temp = ""
            for pair in pairs:
                temp = pair.get(id, "")
                if temp != "":
                    break
            return temp, 200
        else:
            return "Not Found!", 404


class Remove_Pair(Resource):
    def get(self, id):
        update_pairs(id)
        return "Updated!", 200


class Remove_sad(Resource):
    def get(self, id):
        sad_list, happy_list = get_file()
        sad_list.remove(id)
        update_data(sad_list, happy_list)

        return f"Removed {id}", 200


class Remove_happy(Resource):
    def get(self, id):
        sad_list, happy_list = get_file()
        happy_list.remove(id)
        update_data(sad_list, happy_list)

        return f"Removed {id}", 200


api.add_resource(Home, '/')
api.add_resource(Depressed_Get, '/sad')
api.add_resource(Depressed_Put, '/sad/<id>')
api.add_resource(Happy_Get, '/happy')
api.add_resource(Happy_Put, '/happy/<id>')
api.add_resource(Get_Pair, '/pair/<id>')
api.add_resource(Remove_Pair, '/remove/<id>')
api.add_resource(Remove_sad, '/sad/remove/<id>')
api.add_resource(Remove_happy, '/happy/remove/<id>')

# driver function
if __name__ == '__main__':
    app.run(host="0.0.0.0", port=6969)
