#include "cpp_control.h"

CppControl::CppControl(QObject *parent)
    : QObject{parent}
{
    m_timer.setInterval(1000);
    connect(&m_timer, &QTimer::timeout, this, &CppControl::timeout);
}

QString CppControl::getDisplay()
{
    return m_time_counter.toString("hh:mm:ss");
}

void CppControl::start()
{
    m_time_counter.setHMS(0, 0, 0, 0);
    m_timer.start();
    emit timeChanged();
    emit started();
}

void CppControl::stop()
{
    m_timer.stop();
    emit stopped();
}

void CppControl::clear()
{
    m_time_counter.setHMS(0, 0, 0, 0);
    emit cleared();
}

void CppControl::timeout()
{
    m_time_counter = m_time_counter.addSecs(1);
    emit timeChanged();
}
