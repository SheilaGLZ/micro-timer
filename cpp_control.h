#ifndef CPP_CONTROL_H
#define CPP_CONTROL_H

#include <QObject>
#include <QTimer>
#include <QTime>
#include <QVariant>

class CppControl : public QObject
{
    Q_OBJECT

    /* QML will call `getDisplay` (READ) to get the new time as a string.
     * `timeChanged` is the signal to update the display.
     */
    Q_PROPERTY(QString displayString READ getDisplay NOTIFY timeChanged FINAL)

public:
    explicit CppControl(QObject *parent = nullptr);

    QString getDisplay();

    /* QML will receive the following signals */
signals:
    void started();
    void stopped();
    void cleared();
    void timeChanged();

    /* QML will trigger the timer using these slots. */
public slots:
    void start();
    void stop();
    void clear();

private slots:
    void timeout();

private:
    QTimer m_timer;
    QTime m_time_counter;
};

#endif // CPP_CONTROL_H
