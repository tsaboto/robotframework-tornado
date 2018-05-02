FROM fedora:27

RUN dnf -y install python3-pip

RUN pip3 install robotframework
RUN pip3 install robotframework-seleniumlibrary
RUN pip3 install requests
RUN pip3 install robotframework-requests
RUN pip3 install tornado

RUN mkdir /tests

COPY api /tests/DesafioPython
COPY testes /tests/DesafioPython
COPY venv /tests/DesafioPython
COPY .idea /tests/DesafioPython
COPY Dockerfile /tests/DesafioPython
COPY execucao /tests/DesafioPython

WORKDIR /tests/DesafioPython
CMD /tests/DesafioPython/execucao

