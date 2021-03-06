
#editconf -f ../assembly/sys-em.pdb -o conf.gro
cp ../assembly/conf.gro .
cp ../assembly/topol.top .
cp ../assembly/*.itp .
#cp ../assembly/em3.gro conf.gro
#grompp

make_ndx -f conf.gro  << EOF
r POPC | r PIP2
q
EOF


grompp -n -maxwarn 1

python plumed.py

qsubmit.py --topol topol.tpr --jobname "Kir" --cluster biowulf2 --partition niddk --nodes 1 --script=submit.sh --duration 24:00:00
