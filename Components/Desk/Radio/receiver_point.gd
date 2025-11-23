extends TextureRect

var receiver:Receiver

# Called when the node enters the scene tree for the first time.
func setReceiver(recvr:Receiver):
	receiver = recvr
	
	texture = recvr.district.image
