variable "sg_ports" {
  type        = list(number)
  description = "list of ingress ports"
  default     = [8080, 80, 22, 443]
}