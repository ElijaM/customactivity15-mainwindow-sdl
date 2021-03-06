/****************************************************************************
**
** Copyright (C) 2020 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the QtAndroidExtras module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/
#include "mainwindow.h"
#include "ui_mainwindow.h"

#include <QAndroidIntent>

const int REQUEST_CODE = 123;
const jint RESULT_OK = QAndroidJniObject::getStaticField<jint>("android/app/Activity", "RESULT_OK");
MainWindow *MainWindow::m_instance = nullptr;

MainWindow::MainWindow(QWidget *parent)
  : QMainWindow(parent)
  , ui(new Ui::MainWindow)
{
  ui->setupUi(this);
  connect(ui->pushButtonSdl, &QPushButton::released, this, &MainWindow::handleButtonSdl);

  QPushButton* pushButtonSdl2 = new QPushButton("Button SDL2");
  ui->verticalLayout->addWidget(pushButtonSdl2);
  connect(pushButtonSdl2, &QPushButton::released, this, &MainWindow::handleButtonSdl2);

  QPushButton* pushButtonSdl3 = new QPushButton("Button SDL3");
  ui->verticalLayout->addWidget(pushButtonSdl3);
  connect(pushButtonSdl3, &QPushButton::released, this, &MainWindow::handleButtonSdl3);

  m_instance = this;
}

MainWindow::~MainWindow()
{
  delete ui;
}

void MainWindow::handleButtonSdl()
{
    QAndroidIntent activityIntent(QtAndroid::androidActivity().object(),
                                  "org/qtproject/example/activityhandler/CustomActivity");

    QtAndroid::startActivity(
            activityIntent.handle(), REQUEST_CODE,
            [this](int requestCode, int resultCode, const QAndroidJniObject &data) {
                activityReceiver(requestCode, resultCode, data);
            });
}

void MainWindow::handleButtonSdl2()
{
  QAndroidIntent activityIntent(QtAndroid::androidActivity().object(),
                                "org/qtproject/example/activityhandler/Sdl2Activity");

  QtAndroid::startActivity(
          activityIntent.handle(), REQUEST_CODE,
          [this](int requestCode, int resultCode, const QAndroidJniObject &data) {
              activityReceiver(requestCode, resultCode, data);
          });
}

void MainWindow::handleButtonSdl3()
{
  QAndroidIntent activityIntent(QtAndroid::androidActivity().object(),
                                "org/libsdl/app/SDLActivity");

  QtAndroid::startActivity(
          activityIntent.handle(), REQUEST_CODE,
          [this](int requestCode, int resultCode, const QAndroidJniObject &data) {
              activityReceiver(requestCode, resultCode, data);
          });
}

void MainWindow::activityReceiver(int requestCode, int resultCode, const QAndroidJniObject &data)
{
    if (requestCode == REQUEST_CODE) {
        if (resultCode == RESULT_OK) {
            const QAndroidJniObject key = QAndroidJniObject::fromString("message");
            const QAndroidJniObject message = data.callObjectMethod(
                    "getStringExtra", "(Ljava/lang/String;)Ljava/lang/String;", key.object());
            if (message.isValid())
                emit MainWindow::instance()->receiveFromActivityResult(message.toString());
        } else {
            emit MainWindow::instance()->receiveFromActivityResult("Rejected!");
        }
    }
}
