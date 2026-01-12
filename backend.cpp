#include "Backend.h"
#include <QString>
#include <QSqlQuery>
#include <QSqlError>
#include <QCoreApplication>
#include <QDir>


//backend logic


// this is initialization code


MyBackend::MyBackend(QObject *parent)
    : QObject(parent)
{
    initializeDatabase();   // Database constructor.
}

MyBackend::~MyBackend() {

    if(m_db.isOpen()) {
        m_db.close();
    }

}

// This function initializes the database
void MyBackend::initializeDatabase() {

    //sqlite database add krta hai

    m_db = QSqlDatabase::addDatabase("QSQLITE");

    QString path = QCoreApplication::applicationDirPath() + "/bloodbank.db";

    m_db.setDatabaseName(path);

    if (!m_db.open()) {
        qDebug() << "Error: Could not open database!";
        return;
    }

    //creating a query object of QSqlQuery class

    QSqlQuery query;

    // This query checks whether a 'users' table exists or not. If it does not then it creates one.
    query.exec("CREATE TABLE IF NOT EXISTS users (email TEXT, password TEXT)");

    // dropping table to ensure data is fresh
    query.exec("DROP TABLE IF EXISTS centres");

    //This is to create the 'centres' table

    QString createCentres = "CREATE TABLE IF NOT EXISTS centres ("
                            "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                            "name TEXT, "
                            "location TEXT, "
                            "phone TEXT, "
                            "lat REAL, "
                            "lon REAL)";
    query.exec(createCentres);



    // Check if table is empty
    query.exec("SELECT count(*) FROM centres");



    if (query.next() && query.value(0).toInt() == 0) {


        qDebug() << "Seeding Islamabad Data...";


        //adding different blood centre names


        // 1. Pakistan Red Crescent (H-8)
        query.exec("INSERT INTO centres (name, location, phone, lat, lon) VALUES "
                   "('Pakistan Red Crescent Society', 'Sector H-8, Islamabad', '051-9250404', 33.6855, 73.0592)");

        // 2. PIMS Blood Bank (G-8)
        query.exec("INSERT INTO centres (name, location, phone, lat, lon) VALUES "
                   "('PIMS Blood Bank', 'G-8/3, Islamabad', '051-9261170', 33.7077, 73.0551)");

        // 3. Shifa International Hospital (H-8)
        query.exec("INSERT INTO centres (name, location, phone, lat, lon) VALUES "
                   "('Shifa International Blood Bank', 'Pitras Bukhari Rd, H-8/4', '051-8463666', 33.6780, 73.0694)");

        // 4. Jamila Sultana Foundation (Thalassemia Center)
        query.exec("INSERT INTO centres (name, location, phone, lat, lon) VALUES "
                   "('Jamila Sultana Foundation', 'Sector I-9/4, Islamabad', '051-4434991', 33.6558, 73.0535)");

        // 5. Sundas Foundation (F-8)
        query.exec("INSERT INTO centres (name, location, phone, lat, lon) VALUES "
                   "('Sundas Foundation', 'F-8 Markaz, Islamabad', '051-2850851', 33.7153, 73.0357)");

        // 6. Polyclinic Blood Bank (G-6)
        query.exec("INSERT INTO centres (name, location, phone, lat, lon) VALUES "
                   "('FG Polyclinic Blood Bank', 'Luqman Hakeem Rd, G-6/2', '051-9218300', 33.7225, 73.0722)");

        // 7. Ali Medical Centre (F-8)
        query.exec("INSERT INTO centres (name, location, phone, lat, lon) VALUES "
                   "('Ali Medical Centre', 'Kohistan Rd, F-8 Markaz', '051-8090200', 33.7145, 73.0360)");

        // 8. Maroof International Hospital (F-10)
        query.exec("INSERT INTO centres (name, location, phone, lat, lon) VALUES "
                   "('Maroof Int. Hospital', '10th Ave, F-10 Markaz', '051-2222920', 33.6955, 73.0105)");

        // 9. Kulsum International Hospital (Blue Area)
        query.exec("INSERT INTO centres (name, location, phone, lat, lon) VALUES "
                   "('Kulsum Int. Hospital', 'Kulsum Plaza, Blue Area', '051-8446666', 33.7087, 73.0601)");

        // 10. KRL Hospital (G-9)
        query.exec("INSERT INTO centres (name, location, phone, lat, lon) VALUES "
                   "('KRL Hospital', 'Mauve Area, G-9/1', '051-9106270', 33.6872, 73.0335)");

        // test: hardcoded user (updated)
        query.exec("INSERT OR IGNORE INTO users (email, password) VALUES ('Mustafa', 'Apple123')");
    }
}

void MyBackend::addUser(const QString &email, const QString &password) {

    QSqlQuery checkUser;

    // goes thorugh the database and checks if the user exists or not.

    checkUser.prepare("SELECT email FROM users where email = :email AND password = :password");

    checkUser.bindValue(":email", email);

    checkUser.bindValue(":password", password);

    //if sql query runs and user row is found then log this error

    if(checkUser.exec() && checkUser.next() ) {
        qDebug() << "USER ALREADY EXISTS";
    }

    else {
        QSqlQuery query;

        query.prepare("INSERT INTO users (email, password) VALUES (:email, :password)");
                      query.bindValue(":email", email);
                      query.bindValue(":password", password);
                      query.exec();


     if(query.exec() )
        {

        qDebug() << "User created succesfully!";
        emit openSelectionWindow();

        }

        else {
            qDebug() << "Failed to create user..";
}
    }
}

void MyBackend::openSecondWindow() {

    bool allowed = true;

    if(allowed) {
        emit openWindowRequest();    
    }

}

void MyBackend::verifyUser(const QString &email, const QString &password) {
    QSqlQuery query;

    // use of 'prepare' and 'bindValue' to prevent SQL Injection attacks

    query.prepare("SELECT * FROM users WHERE email = :email AND password = :pass");

    query.bindValue(":email", email);

    query.bindValue(":pass", password);

    if (query.exec() && query.next()) {
        // query.next() returns true if a row was found

        emit openSelectionWindow();
    }

    else {
        qDebug() << "Login failed";

    }
}



// search blood centres function, returns a list with key value pairs that qml can read



QVariantList MyBackend::searchBloodCentres(const QString &searchText) {

    QVariantList results;

    QSqlQuery query;

    QString sql = "SELECT * FROM centres";


//checks if user has written any text or not, if not it appends this extra sql command and runs it

    if (!searchText.isEmpty()) {

        sql += " WHERE name LIKE :search";

    }

    query.prepare(sql);

    //if nothing is written in the search bar, display all available blood centres

    if (!searchText.isEmpty())
    {
        query.bindValue(":search", "%" + searchText + "%");
    }

    if (query.exec()) {

        // creates a key-value pair list jo qml read krskta hai

        while (query.next()) {
            QVariantMap map;
            map["name"] = query.value("name").toString();

            map["location"] = query.value("location").toString();

            map["phone"] = query.value("phone").toString();

            map["lat"] = query.value("lat").toDouble();

            map["lon"] = query.value("lon").toDouble();

            results.append(map);
        }


    } else {
        qDebug() << "Search Error:" << query.lastError();
    }

    return results;
}



// exit function


void MyBackend::exitProgram() {

    //logs exit text

    qDebug() << "Exiting program...";

    //closes the app entirely

    QCoreApplication::quit();


}
