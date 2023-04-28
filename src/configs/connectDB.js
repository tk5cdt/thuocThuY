import sql from 'mssql';
const config = {
    user: 'sa',
    password: '123',
    server: 'TRUONG',
    database: 'QL_NHATHUOCTY',
    options: {
        encrypt: true, // for azure
        trustServerCertificate: true // change to true for local dev / self-signed certs
    }
};

export async function connectDB() {
    try{
        const pool = await sql.connect(config);
        return pool;
    }catch(err){
        console.log(err);
    }
}
