FROM mcr.microsoft.com/dotnet/core/sdk:3.1 As build
WORKDIR /src
COPY *.csproj .
RUN dotnet restore
COPY . .
RUN dotnet publish -c Rlease -o out

FROM mcr.microsoft.com/dotnet/core/aspnet
EXPOSE 80
EXPOSE 443
WORKDIR /app
COPY --from=build /src/out .
ENTRYPOINT ["dotnet", "weatherapi.dll"]