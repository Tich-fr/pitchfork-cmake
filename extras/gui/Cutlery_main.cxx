// SPDX-FileCopyrightText: 2022 Timothee Chabat <timo.chabat@gmail.com>
// SPDX-License-Identifier: MIT

#include <pitchfork/MainWidget.h>

#include <QApplication>
#include <QSharedPointer>

using pf::widgets::MainWidget;

int main(int argc, char** argv)
{
  QApplication application(argc, argv);

  auto widget = QSharedPointer<MainWidget>(new MainWidget());
  widget->show();

  return QApplication::exec();
}
