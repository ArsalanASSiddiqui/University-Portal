const {Client}= require('pg');

const client = new Client({
    host:"localhost",
    user:"postgres",
    port:5432,
    password:"siddiqui0311",
    database:"portalData"
})
client.connect()
.then(()=>{
console.log("connected");
})
.catch((err,res)=>{
console.log("err ");

})
client.query(`Select * from us` , (err,res)=>{
    if(!err){
        console.log(res.rows);
    }
    else{
        console.log(err.message);
    }
    client.end;
})