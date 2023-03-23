from flask import Flask, request, jsonify

app = Flask(__name__)

DB = {
    "katalog": {
        "kitaplar": [
            {
                "id": "bk1",
                "yazar": "J. K. Rowling",
                "başlık": "Harry Potter",
                "tür": "Fantastik",
                "fiyat": 40
            },
            {
                "id": "bk2",
                "baskı": 3,
                "yazar": "Miguel de Cervantes",
                "başlık": "Don Kişot",
                "fiyat": 50
            }
        ],
        "plaklar": [
            {
                "albüm": "Love for Sale",
                "şarkıcılar": [
                    "Tony Bennett",
                    "Lady Gaga"
                ],
                "yılı": 2021
            },
            {
                "albüm": "Back in Black",
                "şarkıcılar": [
                    "AC/DC"
                ],
                "yılı": 1980
            }
        ]
    }
}


@app.route("/find-products", methods=["POST"])
def find_products():
    data = request.get_json()
    search_term = data["search-term"]
    search_term = search_term.lower()

    kitaplar = DB["katalog"]["kitaplar"]
    plaklar = DB["katalog"]["plaklar"]

    results = []

    for kitap in kitaplar:
        if search_term in kitap["başlık"].lower():
            results.append(kitap)

    for plak in plaklar:
        if search_term in plak["albüm"].lower():
            results.append(plak)

    have_results = len(results) > 0

    response = {
        "have-results": have_results,
        "results": results
    }
    return jsonify(response)


app.run(host="127.0.0.1", port=5500)
