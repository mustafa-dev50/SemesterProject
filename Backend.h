#ifndef BACKEND_H
#define BACKEND_H
#include <QObject>
#include <QString>
#include <QtSql>


class MyBackend : public QObject
{
    Q_OBJECT

public:
     explicit MyBackend(QObject *parent = nullptr);
    ~MyBackend();

public slots: // -> contains all the functions and stuff that can be accessed outside the class
    Q_INVOKABLE void openSecondWindow();
    Q_INVOKABLE void verifyUser(const QString &email, const QString &password);
    Q_INVOKABLE QVariantList searchBloodCentres(const QString &searchText);
    Q_INVOKABLE void exitProgram();
    Q_INVOKABLE void addUser(const QString &email, const QString &password);

signals:
    void openWindowRequest();
    void openSelectionWindow();

private:
QSqlDatabase m_db;
    void initializeDatabase();
};


#endif // BACKEND_H
