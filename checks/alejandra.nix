{
  runCommand,
  alejandra,
  self,
}:
runCommand "alejandra-test-${self.rev or "0.0.0"}" {} ''
  echo Formatting With Alejandra

  ${alejandra}/bin/alejandra --check ${self} < /dev/null | tee $out
''
