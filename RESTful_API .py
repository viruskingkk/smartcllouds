from flask import Flask
from flask_restful import reqparse, abort, Api, Resource

app = Flask(__name__)
api = Api(app)

USRES = {
{
    "id": "<username>",
    "email": "<email>",
    "mobile": "<mobile>",
    "position": {
        "title": "<title>",
        "department": "<department>"
    }
    },
}


def abort_if_user_doesnt_exist(user_id):
    if user_id not in USERS:
        abort(404, message="User {} doesn't exist".format(user_id))

parser = reqparse.RequestParser()
parser.add_argument('task')



class User(Resource):
    def get(self, user_id):
        abort_if_user_doesnt_exist(user_id)
        return USERS[user_id]

    def delete(self, user_id):
        abort_if_user_doesnt_exist(user_id)
        del UESRS[user_id]
        return '', 204

    def put(self, user_id):
        args = parser.parse_args()
        task = {'task': args['task']}
        UESRS[user_id] = task
        return task, 201


class UserList(Resource):
    def get(self):
        return USERS

    def post(self):
        args = parser.parse_args()
        user_id = int(max(USERS.keys()).lstrip('user')) + 1
        user_id = 'user%i' % user_id
        USERS[user_id] = {'task': args['task']}
        return USERS[user_id], 201


api.add_resource(UserList, '/users')
api.add_resource(User, '/users/<user_id>')


if __name__ == '__main__':
    app.run(debug=True)