import argparse

from conllu import parse_incr


def cmdline_args():
    # Make parser object
    p = argparse.ArgumentParser(
        description="Extracts sentences from a CoNLL file and outputs them "
                    "to stdout.",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter)

    p.add_argument("conll_file",
                   help="Path to the ConNLL file.")

    return p.parse_args()


if __name__ == '__main__':
    args = cmdline_args()

    for token_list in parse_incr(open(args.conll_file)):
        sentence = [
          token["form"].strip() for token in token_list
          if len(token["form"]) and isinstance(token["id"], int)
        ]

        if sentence:
            print(" ".join(sentence))
