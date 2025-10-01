from flask import Flask, request, jsonify

app = Flask(__name__)

VALID_USER = "user1"
VALID_PASSWORD = "pass"


@app.route("/login", methods=["POST"])
def login():
    try:
        data = request.get_json()

        username = data.get("username")
        password = data.get("password")

        if username == VALID_USER and password == VALID_PASSWORD:
            return (
                jsonify(
                     {
                            "access_token": "mi_access_token",
                            "refresh_token": "mi_refresh_token",
                        }
                ),
                200,
            )
        else:
            return jsonify({"message": "Credenciales inválidas"}), 401
    except:
        return jsonify({"message": "Formato inválido"}), 400


if __name__ == "__main__":
    app.run(debug=True)
