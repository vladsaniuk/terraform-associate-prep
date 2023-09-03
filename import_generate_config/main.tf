# import SG
import {
  id = "sg-032b28ba248535d60"
  to = aws_security_group.imported_sg
}

resource "aws_security_group" "imported_sg" {
  description = "This is a SG created via AWS CLI, that will be imported into tf"
}
