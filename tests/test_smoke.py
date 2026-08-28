import app


def test_smoke() -> None:
    assert app.__name__ == "app"