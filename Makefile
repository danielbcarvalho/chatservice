createmigration:
	migrate create -ext=sql -dir=sql/migrations -seq init

migrate:
	migrate -path=sql/migrations -database "mysql://root:root@tcp(localhost:3306)/chat_test" -verbose up

migratedown:
	migrate -path=sql/migrations -database "mysql://root:root@tcp(localhost:3306)/chat_test" -verbose drop	

grpc:
	protoc --go_out=. --go-grpc_out=. proto/chat.proto --experimental_allow_proto3_optional

run:
	go run cmd/chatservice/main.go

# Revome todos os containers forçadamente
docker-rm:
	docker rm -f $(docker ps -a -q)

docker-compose-build:
	docker-compose build --progress=plain

docker-container-bash:
	docker-compose exec mysql bash

mysql-cmd:
	mysql -root -p mysql


.PHONY: migrate createmigration migratedown grpc run