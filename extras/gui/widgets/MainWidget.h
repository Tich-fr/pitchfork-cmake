// SPDX-FileCopyrightText: 2022 Timothee Chabat <timo.chabat@gmail.com>
// SPDX-License-Identifier: MIT

#ifndef pitchforkMainWidget_h
#define pitchforkMainWidget_h

#include <pitchfork/Graph.h>

#include <QLabel>

namespace pf::widgets {

class MainWidget : public QLabel {
  Q_OBJECT //NOLINT

public:
  explicit MainWidget(QWidget* parent = nullptr);

private:
  pf::dag::Graph graph_;
};

}  // namespace pf::widgets

#endif  // pitchforkMainWidget_h
