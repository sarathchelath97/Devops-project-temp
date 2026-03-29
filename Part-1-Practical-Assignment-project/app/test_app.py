import pytest
from app import app as flask_app

@pytest.fixture
def client():
    flask_app.config["TESTING"] = True
    with flask_app.test_client() as client:
        yield client

def test_home(client):
    res = client.get("/")
    assert res.status_code == 200
    data = res.get_json()
    assert data["status"] == "ok"
    assert "message" in data

def test_health(client):
    res = client.get("/health")
    assert res.status_code == 200
    assert res.get_json()["status"] == "healthy"
