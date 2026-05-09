import json

from lambda_function import lambda_handler


def test_should_return_status_200_when_event_is_valid():
    response = lambda_handler({"product_id": "abc-123"}, None)

    assert response["statusCode"] == 200


def test_should_return_event_in_body_when_event_is_valid():
    event = {"product_id": "abc-123", "name": "Wireless Headphones"}

    response = lambda_handler(event, None)

    assert json.loads(response["body"]) == event
