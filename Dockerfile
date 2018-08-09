FROM microsoft/aspnetcore:2.0-nanoserver-1709 AS base
WORKDIR /app
EXPOSE 80

FROM microsoft/aspnetcore-build:2.0-nanoserver-1709 AS build
WORKDIR /src
COPY FamiliaAndrade.csproj ./
RUN dotnet restore /FamiliaAndrade.csproj
COPY . .
WORKDIR /src/
RUN dotnet build FamiliaAndrade.csproj -c Release -o /app

FROM build AS publish
RUN dotnet publish FamiliaAndrade.csproj -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "FamiliaAndrade.dll"]
