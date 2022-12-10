// SPDX-FileCopyrightText: 2022 Timothee Chabat <timo.chabat@gmail.com>
// SPDX-License-Identifier: MIT

#include "MainWidget.h"

#include <QString>

namespace pf::widgets {
//-----------------------------------------------------------------------------
MainWidget::MainWidget(QWidget* parent)
  : QLabel(parent)
  , _graph()
{
  const QString value = QString::number(_graph.value());
  this->setText("Hello World!\nCurrent Calue is " + value);

  constexpr int margin = 20;
  this->setMargin(margin);
}

}  // namespace pf::widgets
