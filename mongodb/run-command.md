db := client.Database("sample_restaurants")
command := bson.D{{"dbStats", 1}}
var result bson.M
err := db.RunCommand(context.TODO(), command).Decode(&result)
if err != nil {
	panic(err)
}
