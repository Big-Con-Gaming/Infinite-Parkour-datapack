from python import *
import src.jumppack as jumppack
def main():
 print("Loading base packs...")
 c("function infinite_parkour:load_base_pack_one")
 jumppack.update_list("base")
 print("loading base pack 2...")
 c("function infinite_parkour:load_base_pack_two")
 jumppack.update_list("v2_showcase")